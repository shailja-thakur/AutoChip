module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'd1;
        end
        else if (train_valid) begin
            case (state)
                2'd0: state <= (train_taken) ? 2'd1 : 2'd0;
                2'd1: state <= (train_taken) ? 2'd2 : 2'd0;
                2'd2: state <= (train_taken) ? 2'd3 : 2'd1;
                2'd3: state <= (train_taken) ? 2'd3 : 2'd2;
                default: state <= 2'd1;
            endcase
        end
    end

endmodule
