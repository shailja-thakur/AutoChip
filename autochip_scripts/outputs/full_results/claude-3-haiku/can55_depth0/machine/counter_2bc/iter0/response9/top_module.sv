module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset to state 1
    end
    else if (train_valid) begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        2'b00: begin
            if (train_taken)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
        2'b01: begin
            if (train_taken)
                next_state = 2'b10;
            else
                next_state = 2'b00;
        end
        2'b10: begin
            if (train_taken)
                next_state = 2'b11;
            else
                next_state = 2'b01;
        end
        2'b11: begin
            if (train_taken)
                next_state = 2'b11;
            else
                next_state = 2'b10;
        end
        default: begin
            next_state = 2'b01; // Reset to state 1
        end
    endcase
end

endmodule
