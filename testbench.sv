module testbench ();

reg clk;
reg rst_n;
reg request;
wire north_green;
wire north_red;
wire north_yellow;
wire south_green;
wire south_red;
wire south_yellow;
wire east_green;
wire east_red;
wire east_yellow;
wire west_green;
wire west_red;
wire west_yellow;

integer correct, wrong;

top DUT (.*);

initial begin
    clk = 0;
    forever
    #10 clk = ~clk;
end

task delay_10_cycles_NS;  // checks for north-south state.
    repeat (10) begin
        @(negedge clk);
        if (!(north_green && south_green && east_red && west_red)) begin
            $display ("Error in north-south state");
            wrong = wrong + 1;
        end
        else
            correct = correct + 1;
    end
        
endtask

task delay_10_cycles_EW;  // checks for east-west state.
    repeat (10) begin
        @(negedge clk);
        if (!(east_green && west_green && north_red && south_red)) begin
            $display ("Error in east-west state");
            wrong = wrong + 1;
        end
        else begin
            correct = correct + 1;
        end
    end
endtask

task delay_3_cycles;  // checks for waiting state.
    repeat (3) begin
        @(negedge clk);
        if (!(north_yellow && south_yellow && east_yellow && west_yellow)) begin
            $display ("Error in waiting state");
            wrong = wrong + 1;
        end
        else begin
            correct = correct + 1;
        end
    end
endtask

task delay_15_cycles_NS;  // checks for north-south state.
    repeat (15) begin
        @(negedge clk);
        if (!(north_green && south_green && east_red && west_red)) begin
            $display ("Error in north-south state");
            wrong = wrong + 1;
        end
        else begin
            correct = correct + 1;
        end
    end
endtask

task delay_15_cycles_EW;  // checks for east-west state.
    repeat (15) begin
        @(negedge clk);
        if (!(east_green && west_green && north_red && south_red)) begin
            $display ("Error in east-west state");
            wrong = wrong + 1;
        end
        else begin
            correct = correct + 1;
        end
    end
endtask

initial begin
    rst_n = 0;
    correct = 0;
    wrong = 0;
    request = 0;
    @(negedge clk);
    rst_n = 1;
    delay_10_cycles_NS();
    delay_3_cycles();
    delay_10_cycles_EW();
    delay_3_cycles();
    delay_10_cycles_NS();
    delay_3_cycles();
    delay_10_cycles_EW();
    delay_3_cycles();
    request = 1;
    delay_15_cycles_NS();
    delay_3_cycles();
    delay_15_cycles_EW();
    delay_3_cycles();
    delay_15_cycles_NS();
    delay_3_cycles();
    delay_15_cycles_EW();
    delay_3_cycles();
    $display("Correct checks : %d , wrong checks : %d" , correct , wrong);
    $stop;
end
endmodule