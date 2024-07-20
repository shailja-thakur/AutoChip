module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state, next_state;
reg [23:0] message;

parameter IDLE = 2'b00,
          BYTE1 = 2'b01,
          BYTE2 = 2'b10,
          BYTE3 = 2'b11;

// State transition
always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic and output logic
always @(*) begin
    case (state)
        IDLE: begin
            done = 0;
            if(in[3] == 1)
                next_state = BYTE1;
            else
                next_state = IDLE;
        end
        BYTE1: begin
            done = 0;
            next_state = BYTE2;
        end
        BYTE2: begin
            done = 0;
            next_state = BYTE3;
        end
        BYTE3: begin
            done = 1;
            next_state = IDLE;
        end
        default: begin
            done = 0;
            next_state = IDLE;
        end
    endcase
end

// Message assembly and output
always @(posedge clk) begin
    if (reset) begin
        out_bytes <= 24'd0;
        message <= 24'd0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    message[23:16] <= in;
            end
            BYTE1: message[15:8] <= in;
            BYTE2: message[7:0] <= in;
            BYTE3: out_bytes <= {message[23:8], in};
        endcase
    end
end

endmodule
