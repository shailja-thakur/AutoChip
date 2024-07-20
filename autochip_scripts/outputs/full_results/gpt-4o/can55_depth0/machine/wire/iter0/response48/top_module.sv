module top_module (
    input wire clk,
    input wire rst,
    output reg [7:0] data_out,
    output reg valid_out
);
    // State declaration
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // Internal signals
    reg [7:0] counter;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Sequential logic for counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end
        else if (state == WAIT) begin
            counter <= counter + 1;
        end
        else begin
            counter <= 0;
        end
    end
    
    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b0;
        valid_out = 1'b0;
        
        case (state)
            IDLE: begin
                if (rst) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT;
                end
            end
            
            WAIT: begin
                if (counter == 8'd10) begin // Assuming 10 is the threshold value
                    next_state = PROCESS;
                end
                else begin
                    next_state = WAIT;
                end
            end
            
            PROCESS: begin
                data_out = 8'hAA; // Example data being processed
                next_state = DONE;
            end
            
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
