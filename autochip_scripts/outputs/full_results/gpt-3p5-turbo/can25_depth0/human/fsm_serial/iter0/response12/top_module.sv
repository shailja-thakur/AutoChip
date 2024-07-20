module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// Declare the states
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Declare the signals
reg         clk_div;
reg         start_bit_detected;
reg [7:0]   data;
reg         stop_bit_detected;
reg [2:0]   state;
 
// Divide the clock frequency by 16 to generate a slower clock signal
always @(posedge clk or posedge reset) begin
    if (reset) begin
        clk_div <= 0;
    end else begin
        clk_div <= ~clk_div;
    end
end

// FSM
always @(posedge clk_div or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    start_bit_detected <= 1;
                    data <= 0;
                end
            end
            
            START_BIT: begin
                state <= DATA_BITS;
            end
            
            DATA_BITS: begin
                if (start_bit_detected) begin
                    data <= {data[6:0], in};
                    if (data == 8'b11111111) begin
                        state <= STOP_BIT;
                    end
                end
            end
            
            STOP_BIT: begin
                if (stop_bit_detected) begin
                    done <= 1;
                    start_bit_detected <= 0;
                    stop_bit_detected <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

// Detect stop bit
always @(posedge clk or posedge reset) begin
    if (reset) begin
        stop_bit_detected <= 0;
    end else begin
        if (state == DATA_BITS && data == 8'b11111111 && in == 1'b1) begin
            stop_bit_detected <= 1;
        end else begin
            stop_bit_detected <= 0;
        end
    end
end

endmodule
