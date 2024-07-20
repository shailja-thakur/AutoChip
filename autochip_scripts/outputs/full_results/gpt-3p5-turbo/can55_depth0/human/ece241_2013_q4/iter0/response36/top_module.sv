module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// State definitions
parameter IDLE = 2'b00;
parameter HIGH_LEVEL = 2'b01;
parameter MID_LEVEL = 2'b10;
parameter LOW_LEVEL = 2'b11;

// Registers
reg [1:0] state;
reg [1:0] previous_state;

// Combinational logic
always @(*) begin
    case (state)
        IDLE: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        HIGH_LEVEL: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        MID_LEVEL: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        LOW_LEVEL: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
    endcase
end

// State machine
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        previous_state <= IDLE;
    end else begin
        previous_state <= state;
        case (state)
            IDLE: begin
                if (s[3])
                    state <= HIGH_LEVEL;
                else if (s[2] && !s[3])
                    state <= MID_LEVEL;
                else if (s[1] && !s[2] && !s[3])
                    state <= LOW_LEVEL;
            end
            HIGH_LEVEL: begin
                if (!s[3])
                    state <= MID_LEVEL;
            end
            MID_LEVEL: begin
                if (s[3])
                    state <= HIGH_LEVEL;
                else if (!s[2] && !s[1])
                    state <= LOW_LEVEL;
            end
            LOW_LEVEL: begin
                if (s[1])
                    state <= MID_LEVEL;
            end
        endcase
    end
end

endmodule
