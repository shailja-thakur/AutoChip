module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] state;

// State definitions
parameter IDLE = 3'b000;
parameter ABOVE_S3 = 3'b001;
parameter BETWEEN_S3_S2 = 3'b010;
parameter BETWEEN_S2_S1 = 3'b011;
parameter BELOW_S1 = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        // Reset state machine to IDLE state
        state <= IDLE;
        
        // Set all outputs to their default values
        fr3 <= 0;
        fr2 <= 0;
        fr1 <= 0;
        dfr <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (s[3]) begin
                    state <= ABOVE_S3;
                end else if (s[2]) begin
                    state <= BETWEEN_S3_S2;
                end else if (s[1]) begin
                    state <= BETWEEN_S2_S1;
                end else begin
                    state <= BELOW_S1;
                end
            end
            ABOVE_S3: begin
                if (!s[3]) begin
                    state <= BETWEEN_S3_S2;
                end
            end
            BETWEEN_S3_S2: begin
                if (s[3]) begin
                    state <= ABOVE_S3;
                end else if (!s[2]) begin
                    state <= BETWEEN_S2_S1;
                end
            end
            BETWEEN_S2_S1: begin
                if (s[2]) begin
                    state <= BETWEEN_S3_S2;
                end else if (!s[1]) begin
                    state <= BELOW_S1;
                end
            end
            BELOW_S1: begin
                if (s[1]) begin
                    state <= BETWEEN_S2_S1;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            fr1 = 0;
            fr2 = 0;
            fr3 = 0;
            dfr = 0;
        end
        ABOVE_S3: begin
            fr1 = 0;
            fr2 = 0;
            fr3 = 0;
            dfr = 0;
        end
        BETWEEN_S3_S2: begin
            fr1 = 1;
            fr2 = 0;
            fr3 = 0;
            dfr = 0;
        end
        BETWEEN_S2_S1: begin
            fr1 = 1;
            fr2 = 1;
            fr3 = 0;
            dfr = 0;
        end
        BELOW_S1: begin
            fr1 = 1;
            fr2 = 1;
            fr3 = 1;
            dfr = 0;
        end
    endcase
end

endmodule
