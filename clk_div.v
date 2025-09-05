/*
Design description:
Name: clock_divider
Functionality: makes the operational clock of the counter module with period 1 second,
    as it works with system clocks 10 ns.
Algorithm: using 27-bit counter (the minimum size),
    it counts 0 -> {3'b011 , {6{1'hf}}} for the positive half cycle,
    and counts {3'b100 , {6{1'hf}}} -> {3'b111 , {6{1'hf}}} for the negative half cycle.
    To maintain low-power, this design avoids the comparsio with rational operations like <, >,
    and uses the complement of 27th bit to be the output clock.
*/
module clock_divider (
    input clk,  // system clock
    input rst_n,  // system reset (asynchronous active-low reset)
    output reg op_clk  // operation clock                        
);

reg [26: 0] i;  // counter

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)
        i <= 27'b0;
    else
        i <= i + 27'b1;
end

always @ (*) begin
    if (!rst_n)
        op_clk = clk;
    else
        op_clk = ~i[26];
end
endmodule