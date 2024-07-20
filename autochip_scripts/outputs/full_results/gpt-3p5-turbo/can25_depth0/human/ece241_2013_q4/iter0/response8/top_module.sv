module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

// State variables
reg [2:0] state;
reg [2:0] prev_state;

// Constants
localparam IDLE = 3'b000;
localparam ABOVE_S3 = 3'b001;
localparam BETWEEN_S3_S2 = 3'b010;
localparam BETWEEN_S2_S1 = 3'b011;
localparam BELOW_S1 = 3'b100;

// Reset state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        prev_state <= IDLE;
    end else begin
        state <= next_state;
        prev_state <= state;
    end
end

// Next state logic
reg [2:0] next_state;
always @(*) begin
    next_state = state;
    case(state)
        IDLE: begin
            if (s[3]) begin
                next_state = ABOVE_S3;
            end else if (s[2] && s[1]) begin
                next_state = BETWEEN_S3_S2;
            end else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end else begin
                next_state = BELOW_S1;
            end
        end
        ABOVE_S3: begin
            if (!s[3]) begin
                next_state = IDLE;
            end
        end
        BETWEEN_S3_S2: begin
            if (!s[2] || !s[1]) begin
                next_state = IDLE;
            end
        end
        BETWEEN_S2_S1: begin
            if (!s[1]) begin
                next_state = IDLE;
            end
        end
        BELOW_S1: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    case(next_state)
        IDLE: begin
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
        end
        ABOVE_S3: begin
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
        end
        BETWEEN_S3_S2: begin
            fr3 <= s[2] ? 1 : 0;
            fr2 <= s[2] ? 0 : 1;
            fr1 <= 1;
            dfr <= s[2] ? 0 : 1;
        end
        BETWEEN_S2_S1: begin
            fr3 <= s[1] ? 0 : 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
        BELOW_S1: begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
    endcase
end

endmodule
