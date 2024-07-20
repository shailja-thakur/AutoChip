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
        end else begin
            case (state)
                3'b000: begin // A
                    if (w) begin
                        state <= 3'b000;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b001: begin // B
                    if (w) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin // C
                    if (w) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b010: begin // F
                    if (w) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b100;
                    end
                end
                3'b100: begin // D
                    if (w) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin // A
                    if (w) begin
                        state <= 3'b000;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b010: begin // E
                    if (w) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b100;
                    end
                end
                3'b100: begin // D
                    if (w) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            3'b000: z = 1'b0; // A
            3'b001: z = 1'b0; // B
            3'b011: z = 1'b0; // C
            3'b010: z = 1'b0; // F
            3'b100: z = 1'b0; // D
            3'b010: z = 1'b1; // E
            3'b100: z = 1'b1; // D
        endcase
    end
endmodule
