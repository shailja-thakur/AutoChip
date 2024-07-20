module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define the state encoding
    localparam STATE_A = 2'd0;
    localparam STATE_B = 2'd1;
    localparam STATE_C = 2'd2;
    localparam STATE_D = 2'd3;

    // State register
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end
        else begin
            case (state)
                STATE_A: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
                STATE_B: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_C;
                    end
                end
                STATE_C: begin
                    if (in) begin
                        state <= STATE_D;
                    end
                    else begin
                        state <= STATE_A;
                    end
                end
                STATE_D: begin
                    if (in) begin
                        state <= STATE_B;
                    end
                    else begin
                        state <= STATE_C;
                    end
                end
                default: begin
                    state <= STATE_A;
                end
            endcase
        end
    end

    // Output logic
    assign out = (state == STATE_D);

endmodule
