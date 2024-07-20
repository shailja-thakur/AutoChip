module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

localparam STATE_0 = 2'd0;
localparam STATE_1 = 2'd1;
localparam STATE_2 = 2'd2;
localparam STATE_3 = 2'd3;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_1;
    end
    else if (train_valid) begin
        case (state)
            STATE_0: begin
                if (train_taken) begin
                    state <= STATE_1;
                end
                else begin
                    state <= STATE_0;
                end
            end
            STATE_1: begin
                if (train_taken) begin
                    state <= STATE_2;
                end
                else begin
                    state <= STATE_0;
                end
            end
            STATE_2: begin
                if (train_taken) begin
                    state <= STATE_3;
                end
                else begin
                    state <= STATE_1;
                end
            end
            STATE_3: begin
                if (train_taken) begin
                    state <= STATE_3;
                end
                else begin
                    state <= STATE_2;
                end
            end
            default: begin
                state <= STATE_1;
            end
        endcase
    end
end

endmodule
