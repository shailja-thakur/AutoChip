module top_module (
    input clk,
    input in, 
    output out);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (in) begin
            state <= 1;
        end else begin
            state <= 0;
        end
    end

    assign out = state;

endmodule