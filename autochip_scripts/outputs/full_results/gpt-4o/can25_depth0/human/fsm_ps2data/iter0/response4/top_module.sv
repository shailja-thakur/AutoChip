module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // States for the FSM
    typedef enum reg [1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
    } state_t;
    
    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // Sequential logic for current state
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default assignments
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Logic for capturing bytes and generating the output signal
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
        end else begin
            case (state)
                IDLE: begin
                    out_bytes <= 24'd0; // Clear output in IDLE state
                end
                
                BYTE1: begin
                    byte1 <= in;
                end
                
                BYTE2: begin
                    byte2 <= in;
                end
                
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3}; // Output all bytes when done
                end
            endcase
        end
    end

endmodule
