module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    // Internal register to store the current state
    reg [2:0] state;

    always @(posedge clk) begin
        if (a == 1) begin
            state <= 3'd4;
        end else begin
            state <= state + 1;
        end
        
        if (state == 3'd7) begin
           state <= 3'd0;
        end

        q <= state;
    end
endmodule
