module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin // Initial state or end of frame (0 after 01111110)
                    if (in) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin // 1st 1 after 01111110
                    if (in) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin // 2nd 1 after 01111110
                    if (in) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin // 3rd 1 after 01111110
                    if (in) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b100: begin // 4th 1 after 01111110
                    if (in) begin
                        state <= 3'b101;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b101: begin // 5th 1 after 01111110
                    if (in) begin
                        state <= 3'b110;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b110: begin // 6th 1 after 01111110
                    if (in) begin
                        state <= 3'b111;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b111: begin // 7th or more 1 after 01111110
                    if (in) begin
                        state <= 3'b111;
                    end else begin
                        state <= 3'b000;
                    end
                end
                default: begin
                    state <= 3'b000;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            3'b001: begin // Discard when 0111110 is detected
                disc <= 1'b1;
                flag <= 1'b0;
                err <= 1'b0;
            end
            3'b110: begin // Flag when 01111110 is detected
                disc <= 1'b0;
                flag <= 1'b1;
                err <= 1'b0;
            end
            3'b111: begin // Error when 7 or more 1s are detected
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b1;
            end
            default: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase
    end
endmodule
