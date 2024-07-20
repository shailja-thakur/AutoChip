module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else if (train_valid) begin
            case (state)
                2'b00: state <= train_taken ? 2'b01 : 2'b00;
                2'b01: state <= train_taken ? 2'b11 : 2'b00;
                2'b10: state <= train_taken ? 2'b11 : 2'b10;
                2'b11: state <= train_taken ? 2'b11 : 2'b10;
            endcase
        end
    end

endmodule
