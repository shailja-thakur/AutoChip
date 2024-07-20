module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    // State definitions
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_reg;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = state; // default to hold state
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: next_state = RECEIVE;
            RECEIVE: begin
                if (bit_count == 4'd8) 
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;  
            end
            ERROR: begin
                if (in == 1'b1) // wait for line to be idle
                    next_state = IDLE;
            end
        endcase
    end
    
    // Output and bit counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 4'd0;
            data_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 4'd0;
                    done <= 1'b0;
                end
                START: begin
                    bit_count <= 4'd0;
                end
                RECEIVE: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= data_reg;
                        done <= 1'b1;
                    end
                end
                ERROR: begin
                    done <= 1'b0;
                end
            endcase
        end
    end
endmodule
