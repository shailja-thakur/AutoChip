module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the state register
    reg [3:0] state;

    // Define the states
    localparam A = 4'b0000;
    localparam B = 4'b0001;
    localparam C = 4'b0010;
    localparam D = 4'b0011;
    localparam E = 4'b0100;
    localparam F = 4'b0101;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                    z <= 0;
                end
                B: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                    z <= 0;
                end
                C: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                    z <= 0;
                end
                D: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= F;
                    end
                    z <= 0;
                end
                E: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                    z <= 1;
                end
                F: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                    z <= 1;
                end
                default: begin
                    state <= A;
                    z <= 0;
                end
            endcase
        end
    end

endmodule
