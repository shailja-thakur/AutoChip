module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    reg [3:0] state;
    reg [3:0] next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;
    
    localparam IDLE = 4'd0;
    localparam START_BIT = 4'd1;
    localparam DATA_BIT = 4'd2;
    localparam STOP_BIT = 4'd3;
    
    // State transition logic (combinational)
    always @(*) begin
        next_state = state;
        done = 1'b0;
        
        case(state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BIT;
                bit_counter = 3'b000;  // Reset bit counter
            end
            DATA_BIT: begin
                if (bit_counter == 3'b111)  // Last data bit received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin  // Stop bit correctly received
                    done = 1'b1;
                    next_state = IDLE;
                end else begin // Incorrect or missing stop bit, wait for next stop bit
                    next_state = STOP_BIT;
                end
            end
            default: next_state = IDLE;
        endcase
    end
  
    // Sequential logic: state update and bit shifting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
            data_byte <= 8'd0;
            bit_counter <= 3'b000;
        end else begin
            state <= next_state;
            
            case(state)
                DATA_BIT: begin
                    data_byte[bit_counter] <= in; // Shift in data bits
                    bit_counter <= bit_counter + 1'b1;
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin  // Save byte on successful stop bit
                        out_byte <= data_byte;
                    end
                end
            endcase
        end
    end

endmodule
