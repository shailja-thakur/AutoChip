module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    wire [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;  // Initializing state to A on reset
        end else begin
            state <= next_state;  // Updating state on clock edge
        end
    end

    assign next_state = (state == 2'b00 && in) ? 2'b01 :
                       (state == 2'b01 && in) ? 2'b01 :
                       (state == 2'b01 && !in) ? 2'b10 :
                       (state == 2'b10 && in) ? 2'b11 :
                       (state == 2'b10 && !in) ? 2'b00 :
                       (state == 2'b11 && in) ? 2'b01 :
                       (state == 2'b11 && !in) ? 2'b10 : 2'b00;

    assign out = (state == 2'b11);  // Setting output to 1 when in state D

endmodule
