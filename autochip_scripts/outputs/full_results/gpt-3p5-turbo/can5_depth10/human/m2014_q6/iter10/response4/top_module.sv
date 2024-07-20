module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end
        else begin
            case (state)
                3'b000: begin // A
                    if (w)
                        state <= 3'b001; // Go to B
                    else begin
                        state <= 3'b000; // Stay in A
                        z <= 0;
                    end
                end

                3'b001: begin // B
                    if (w)
                        state <= 3'b010; // Go to C
                    else
                        state <= 3'b011; // Go to D
                end

                3'b010: begin // C
                    if (w)
                        state <= 3'b101; // Go to F
                    else
                        state <= 3'b101; // Go to F
                end

                3'b011: begin // D
                    if (w)
                        state <= 3'b000; // Go to A
                    else
                        state <= 3'b100; // Go to E
                end

                3'b100: begin // E
                    if (w)
                        state <= 3'b011; // Go to D
                    else
                        state <= 3'b110; // Go to E
                end

                3'b101: begin // F
                    if (w)
                        state <= 3'b011; // Go to D
                    else
                        state <= 3'b010; // Go to C
                end

                default: state <= 3'b000; // Default state is A
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            3'b000: z <= 1'b0; // A
            3'b001: z <= 1'b0; // B
            3'b010: z <= 1'b1; // C
            3'b011: z <= 1'b0; // D
            3'b100: z <= 1'b1; // E
            3'b101: z <= 1'b0; // F
            default: z <= 1'b0;
        endcase
    end

endmodule
