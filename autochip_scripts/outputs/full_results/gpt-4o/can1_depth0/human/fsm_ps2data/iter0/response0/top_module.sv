module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // Registers to hold message bytes
    reg [7:0] byte1, byte2, byte3;

    // Combinational logic for state transitions and outputs
    always @(*) begin
        // Default values
        next_state = state;
        done = 0;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            
            BYTE1: next_state = BYTE2;

            BYTE2: next_state = BYTE3;

            BYTE3: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

    // Sequential logic to update state and register values
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
        end else begin
            state <= next_state;
            case (next_state)
                BYTE1: byte1 <= in;
                BYTE2: byte2 <= in;
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                end
            endcase
        end
    end
endmodule
