module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

    // State Encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message;

    // State Transition 
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = state; // default state 
        done = 0;
        case(state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = IDLE;
                done = 1;
            end
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
        end else begin
            case (state)
                BYTE1: message[23:16] <= in;
                BYTE2: message[15:8] <= in;
                BYTE3: message[7:0] <= in;
                default: ;
            endcase
            
            if (done)
                out_bytes <= message;
        end
    end

endmodule
