module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the state register
    reg [2:0] state;

    // Define the states
    localparam A = 3'd0;
    localparam B = 3'd1;
    localparam C = 3'd2;
    localparam D = 3'd3;
    localparam E = 3'd4;
    localparam F = 3'd5;

    // Next state logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                end
                C: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                end
                D: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= F;
                    end
                end
                E: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                end
                F: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(state) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
