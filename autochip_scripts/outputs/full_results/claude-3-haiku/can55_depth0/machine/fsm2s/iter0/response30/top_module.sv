module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define the two states
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Define the state register
    reg state;

    // Initialize the state to A
    initial begin
        state = STATE_A;
    end

    // Define the state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end
        else begin
            case (state)
                STATE_A: begin
                    if (j) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
                STATE_B: begin
                    if (k) begin
                        state <= STATE_A;
                    end
                    else begin
                        state <= STATE_B;
                    end
                end
                default: begin
                    state <= STATE_A;
                end
            endcase
        end
    end

    // Define the output logic
    always @(state) begin
        case (state)
            STATE_A: begin
                out = 1'b0;
            end
            STATE_B: begin
                out = 1'b1;
            end
            default: begin
                out = 1'b0;
            end
        endcase
    end

endmodule
