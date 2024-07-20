module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Reset to initial state
            fr1 <= 1'b0;
            fr2 <= 1'b0;
            fr3 <= 1'b0;
            dfr <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // No sensors asserted
                    if (s[3]) begin
                        state <= 2'b01; // Transition to between s[3] and s[2]
                    end else begin
                        state <= 2'b00; // Stay in current state
                    end
                end
                2'b01: begin // Between s[3] and s[2]
                    if (!s[3]) begin
                        state <= 2'b02; // Transition to between s[2] and s[1]
                    end else if (s[1]) begin
                        state <= 2'b00; // Transition to above s[3]
                    end else begin
                        state <= 2'b01; // Stay in current state
                    end

                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end
                2'b02: begin // Between s[2] and s[1]
                    if (!s[2]) begin
                        state <= 2'b01; // Transition to between s[3] and s[2]
                    end else if (s[1]) begin
                        state <= 2'b10; // Transition to below s[1]
                    end else begin
                        state <= 2'b02; // Stay in current state
                    end

                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end
                2'b10: begin // Below s[1]
                    if (s[1]) begin
                        state <= 2'b02; // Transition to between s[2] and s[1]
                    end else begin
                        state <= 2'b10; // Stay in current state
                    end

                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    fr3 <= 1'b1;
                    dfr <= 1'b0;
                end
                default: state <= 2'b00; // Default case, should not be reached
            endcase
        end
    end
endmodule
