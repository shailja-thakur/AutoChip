module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // Declare state enumeration
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_type;
    
    // Declare registers
    reg [2:0] state, next_state;
    reg [7:0] data_reg;
    
    // Declare wire for start bit, data bits, and stop bit
    wire start_bit, stop_bit;
    wire [7:0] data_bits;
    
    // Declare FSM signals
    reg [2:0] bit_count;
    reg [3:0] error_count;
    
    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_reg <= 8'b0;
            bit_count <= 0;
            error_count <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        next_state <= START_BIT;
                        bit_count <= 0;
                        error_count <= 0;
                    end
                end
                START_BIT: begin
                    next_state <= DATA_BITS;
                    bit_count <= 0;
                    error_count <= 0;
                end
                DATA_BITS: begin
                    if (bit_count < 8) begin
                        next_state <= DATA_BITS;
                        bit_count <= bit_count + 1;
                        data_reg <= {data_reg[6:0], in};
                    end
                    else begin
                        next_state <= STOP_BIT;
                        bit_count <= 0;
                    end
                end
                STOP_BIT: begin
                    if (bit_count < 1) begin
                        if (in == 1'b1) begin
                            next_state <= IDLE;
                            bit_count <= 0;
                            done <= 1;
                        end
                        else begin
                            next_state <= STOP_BIT;
                            bit_count <= bit_count + 1;
                            error_count <= error_count + 1;
                        end
                    end
                    else begin
                        next_state <= IDLE;
                        bit_count <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end
    
    // Combinational logic for start bit, data bits, and stop bit
    assign start_bit = (state == START_BIT);
    assign data_bits = data_reg;
    assign stop_bit = (state == STOP_BIT);
    
endmodule
