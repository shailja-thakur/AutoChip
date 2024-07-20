module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else begin
            case ({train_valid, train_taken})
                2'b10: if (state < 2'b11) state <= state + 1;
                2'b01: if (state > 2'b00) state <= state - 1;
            endcase
        end
    end

endmodule
