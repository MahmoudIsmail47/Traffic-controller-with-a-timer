module top (
    input clk,
    input rst_n,
    input request,
    output _north_green_,
    output _north_red_,
    output _north_yellow_,
    output _south_green_,
    output _south_red_,
    output _south_yellow_,
    output _east_green_,
    output _east_red_,
    output _east_yellow_,
    output _west_green_,
    output _west_red_,
    output _west_yellow_
);

wire [4:0] counts;
wire ctrl;
wire op_clk;

clock_divider clk_div (
    .clk(clk),
    .op_clk(op_clk),
    .rst_n(rst_n)
);

counter counter_block (
    .clk(op_clk),
    .rst_n(rst_n),
    .request(request),
    .ctrl(ctrl),
    .counts(counts)
);

fsm fsm_block (
    .ctrl(ctrl),
    .clk(op_clk),
    .rst_n(rst_n),
    .north_green(_north_green_),
    .north_red(_north_red_),
    .north_yellow(_north_yellow_),
    .south_green(_south_green_),
    .south_red(_south_red_),
    .south_yellow(_south_yellow_),
    .east_green(_east_green_),
    .east_red(_east_red_),
    .east_yellow(_east_yellow_),
    .west_green(_west_green_),
    .west_red(_west_red_),
    .west_yellow(_west_yellow_)
);
endmodule