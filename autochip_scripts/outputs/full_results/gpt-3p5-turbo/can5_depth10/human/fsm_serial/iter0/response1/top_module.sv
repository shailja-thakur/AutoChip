module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    
    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;
    
    // Define signals
    reg [2:0] curr_state;
    reg [7:0] data;
    reg [2:0] bit_count;
    reg start_bit_found;
    reg stop_bit_found;
    
    // Define constants
    parameter STOP_BIT_VALUE = 1'b1;
    
    // Define outputs
    assign done = (curr_state == STOP_BIT);
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= IDLE;
        end else begin
            case (curr_state)
                IDLE:
                    if (in == 1'b0) begin
                        curr_state <= START_BIT;
                        bit_count <= 0;
                        start_bit_found <= 0;
                        stop_bit_found <= 0;
                        data <= 0;
                    end
                START_BIT:
                    if (in == 1'b1) begin
                        curr_state <= DATA_BITS;
                        bit_count <= 0;
                        data <= 0;
                    end
                DATA_BITS:
                    if (bit_count == 7) begin
                        curr_state <= STOP_BIT;
                    end else begin
                        curr_state <= DATA_BITS;
                        bit_count <= bit_count + 1;
                        data <= {data[6:0], in};
                    end
                STOP_BIT:
                    if (in == STOP_BIT_VALUE) begin
                        curr_state <= IDLE;
                    end
                default:
                    curr_state <= IDLE;
            endcase
        end
    end
    
endmodule
