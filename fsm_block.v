/*
Design description:
Name: FSM
Functionality: controls the lights of each way, using ctrl signal from counter.
states:
    s0: north-south green west-east red.
    s1: all is yellow for 3 seconds.
    s2: west-east green north-south red.
    s4: all is yellow for 3 seconds.
    s0 -> s1 -> s2 -> s3 -> s0      in moore formation.
*/
module fsm (
    input ctrl,
    input clk,
    input rst_n,
    output reg north_green,
    output reg north_red,
    output reg north_yellow,
    output reg south_green,
    output reg south_red,
    output reg south_yellow,
    output reg east_green,
    output reg east_red,
    output reg east_yellow,
    output reg west_green,
    output reg west_red,
    output reg west_yellow
);

localparam s0 = 2'b0, s1 = 2'b1, s2 = 2'b10, s3 = 2'b11;
reg [1:0] cs, ns;

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)
        cs <= s0;
    else 
        cs <= ns;
end                                                             

always @ (*) begin
    north_green = 1'b0;
    north_red = 1'b0;
    north_yellow = 1'b0;
    south_green = 1'b0;
    south_red = 1'b0;
    south_yellow = 1'b0;
    east_green = 1'b0;
    east_red = 1'b0;
    east_yellow = 1'b0;
    west_green = 1'b0;
    west_red = 1'b0;
    west_yellow = 1'b0;
    case (cs)
        s0: begin
            north_green = 1'b1;
            south_green = 1'b1;
            east_red = 1'b1;
            west_red = 1'b1;
            if (ctrl)
                ns = s0;
            else 
                ns = s1;
        end
        s1: begin
            north_yellow = 1'b1;
            south_yellow = 1'b1;
            west_yellow = 1'b1;
            east_yellow = 1'b1;
            if (ctrl)
                ns = s2;
            else 
                ns = s1;
        end
        s2: begin
            east_green = 1'b1;
            west_green = 1'b1;
            north_red = 1'b1;
            south_red = 1'b1;
            if (ctrl)
                ns = s2;
            else 
                ns = s3;
        end
        s3: begin
            north_yellow = 1'b1;
            south_yellow = 1'b1;
            west_yellow = 1'b1;
            east_yellow = 1'b1;
            if (ctrl)
                ns = s0;
            else 
                ns = s3;
        end
    endcase
end
endmodule