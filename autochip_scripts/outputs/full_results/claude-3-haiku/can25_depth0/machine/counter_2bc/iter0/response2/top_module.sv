module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    case (state)
        2'b00: next_state = train_taken ? 2'b01 : 2'b00;
        2'b01: next_state = train_taken ? 2'b10 : 2'b00;
        2'b10: next_state = train_taken ? 2'b11 : 2'b01;
        2'b11: next_state = train_taken ? 2'b11 : 2'b10;
        default: next_state = 2'b01;
    endcase
end

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01;
    else if (train_valid)
        state <= next_state;
end

endmodule
