module top_module (
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State declarations
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    state_t state, next_state;
    
    reg [7:0] counter;
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            WAIT: 
                if (counter == 8'd10) 
                    next_state = PROCESS;
                else 
                    next_state = WAIT;
            PROCESS: 
                next_state = DONE;
            DONE: 
                next_state = IDLE;
            default: 
                next_state = IDLE;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Output logic and counter update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else if (state == PROCESS) begin
            data_out <= 8'hFF; // Example processed data
            valid_out <= 1'b0;
        end else if (state == DONE) begin
            valid_out <= 1'b1;
        end else if (state == IDLE) begin
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end
    end

endmodule
