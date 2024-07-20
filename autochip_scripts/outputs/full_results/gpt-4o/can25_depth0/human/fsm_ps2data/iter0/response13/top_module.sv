module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] bytes;
    
    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // State machine next state logic
    always_comb begin
        done = 1'b0;
        next_state = state;
        case(state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end
            end
            
            BYTE_1: begin
                next_state = BYTE_2;
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
            end
            
            BYTE_3: begin
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
    
    // Handle the output bytes
    always_ff @(posedge clk) begin
        if (reset) begin
            bytes <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            if (done) begin
                out_bytes <= bytes;
            end
            case (state)
                BYTE_1: bytes[23:16] <= in;
                BYTE_2: bytes[15:8]  <= in;
                BYTE_3: bytes[7:0]   <= in;
            endcase
        end
    end
endmodule
