module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM state declarations
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        RECEIVE  = 3'b010,
        STOP     = 3'b011,
        ERROR    = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] byte_data;
    
    // Synchronous state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            byte_data <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;
            
            // FSM Output logic for data capturing
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in == 0) begin
                        next_state <= START;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                
                START: begin
                    bit_counter <= 0;
                    if (in == 0) begin
                        next_state <= RECEIVE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                
                RECEIVE: begin
                    byte_data[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 3'b111) begin
                        next_state <= STOP;
                    end else begin
                        next_state <= RECEIVE;
                    end
                end
                
                STOP: begin
                    if (in == 1) begin
                        out_byte <= byte_data;
                        done <= 1;
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                
                ERROR: begin
                    done <= 0;
                    if (in == 1) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                
                default: next_state <= IDLE;
            endcase
        end
    end
    
endmodule
