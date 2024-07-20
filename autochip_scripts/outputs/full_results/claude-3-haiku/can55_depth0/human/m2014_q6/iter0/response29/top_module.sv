module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam STATE_A = 2'd0;
localparam STATE_B = 2'd1;
localparam STATE_C = 2'd2;
localparam STATE_D = 2'd3;
localparam STATE_E = 2'd4;
localparam STATE_F = 2'd5;

// Register to hold the current state
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state to A
        state <= STATE_A;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_A: begin
                if (w == 1'b0) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_B: begin
                if (w == 1'b0) begin
                    state <= STATE_C;
                end
                else begin
                    state <= STATE_D;
                end
            end
            STATE_C: begin
                if (w == 1'b0) begin
                    state <= STATE_E;
                end
                else begin
                    state <= STATE_D;
                end
            end
            STATE_D: begin
                if (w == 1'b0) begin
                    state <= STATE_F;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_E: begin
                if (w == 1'b0) begin
                    state <= STATE_E;
                end
                else begin
                    state <= STATE_D;
                end
            end
            STATE_F: begin
                if (w == 1'b0) begin
                    state <= STATE_C;
                end
                else begin
                    state <= STATE_D;
                end
            end
            default: begin
                state <= STATE_A;
            end
        endcase

        // Set the output z based on the current state
        if (state == STATE_E || state == STATE_F) begin
            z <= 1'b1;
        end
        else begin
            z <= 1'b0;
        end
    end
end

endmodule
