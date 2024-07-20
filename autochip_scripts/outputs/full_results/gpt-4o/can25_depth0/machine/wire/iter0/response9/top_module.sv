module top_module(
    input clk,           // Clock input
    input reset,         // Reset input
    output reg [7:0] data_out,     // Data output
    output reg valid_out // Valid output
);
    
    // Define FSM states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state;        // FSM state
    reg [3:0] counter;    // Counter to keep track of clock cycles
    
    // FSM and data processing logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                    if (counter == 4'b1111) begin
                        state <= PROCESS;
                    end
                end
                
                PROCESS: begin
                    data_out <= 8'b10101010;  // Example data
                    state <= DONE;
                end
                
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
    
endmodule
