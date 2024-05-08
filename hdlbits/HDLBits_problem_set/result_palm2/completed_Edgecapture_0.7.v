module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] state;
    reg [31:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 32'h0;
        end else begin
            next_state <= state;
            for (i = 0; i < 32; i++) begin
                if (in[i] == 1'b1 && state[i] == 1'b0) begin
                    next_state[i] <= 1'b1;
                end
            end
            state <= next_state;
        end
    end

    assign out = state;

endmodule