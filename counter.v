/*
Design description:
Name: counter
Functionality: counts up from 0 to 17 as maximum count.
    control the signal "ctrl" that control the FSM, and handles with pedestrian request.
ctrl signal: if equal 1, means that green and red lights are ON,
    if not, means that yellow is ON.
Algorithm: using 5-bit up counter, for cases:
    1. reset: counts will equal to 0. ctrl sig will be 1.
    2. pedestrian request = 0: counts up to 12 divided by: 0 -> 9 ctrl = 1, 10 -> 12 ctrl = 0.
    3. pedestrian request = 1: counts up to 12 divided by: 0 -> 14 ctrl = 1, 15 -> 17 ctrl = 0.
*/
module counter (
    input clk,
    input rst_n,
    input request,
    output reg ctrl
);

reg [4:0] counts;
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n )
        counts <= 5'b0;
    else if (request) begin
        if (counts == 5'b10001)
            counts <= 5'b0;
        else 
            counts <= counts + 1'b1;
    end
    else begin
        if (counts == 5'b01100)
            counts <= 5'b0;
        else
            counts <= counts + 1'b1;
    end  
end

always @ (*) begin
    if (request) begin
        ctrl = ~(counts[4] | &counts[3:0]);
    end
    else begin
        ctrl = ~(&counts[3:2] | (counts[3] & counts[1]));        
    end
end
endmodule