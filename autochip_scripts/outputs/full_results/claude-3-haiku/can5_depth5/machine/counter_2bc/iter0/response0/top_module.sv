module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01;
    end
    else if (train_valid) begin
        case (state)
            2'b00: if (train_taken) state <= 2'b01;
                  else state <= 2'b00;
            2'b01: if (train_taken) state <= 2'b10;
                  else state <= 2'b00;
            2'b10: if (train_taken) state <= 2'b11;
                  else state <= 2'b01;
            2'b11: if (train_taken) state <= 2'b11;
                  else state <= 2'b10;
            default: state <= 2'b01;
        endcase
    end
end

endmodule
