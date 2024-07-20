module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    case ({train_valid, train_taken})
        2'b00: next_state = state;
        2'b01: next_state = (state == 2'b00) ? 2'b00 : state - 1'b1;
        2'b10: next_state = (state == 2'b11) ? 2'b11 : state + 1'b1;
        2'b11: next_state = (state == 2'b11) ? 2'b11 : state + 1'b1;
    endcase
end

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;
    end
    else begin
        state <= next_state;
    end
end

endmodule
