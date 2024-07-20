module top_module(
    input clk,
    input rst,
    output reg data_out,
    output reg valid_out
);

    // State declaration
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;  // Adjust size as needed

    // State transition logic (combinational)
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (rst)
                    next_state = WAIT;
            end
            
            WAIT: begin
                if (counter == 4'b1111)  // Threshold value, adjust as needed
                    next_state = PROCESS;
            end
            
            PROCESS: begin
                next_state = DONE;
            end
            
            DONE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // State and counter update logic (sequential)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else
                counter <= 4'b0000;
        end
    end

    // Output logic (combinational)
    always @(*) begin
        data_out = 0;
        valid_out = 0;
        case (state)
            IDLE: begin
                data_out = 0;
                valid_out = 0;
            end
            
            WAIT: begin
                data_out = 0;
                valid_out = 0;
            end
            
            PROCESS: begin
                data_out = /* Your data here */;
                valid_out = 0;
            end
            
            DONE: begin
                data_out = /* Your data here */;
                valid_out = 1;
            end
            
            default: begin
                data_out = 0;
                valid_out = 0;
            end
        endcase
    end

endmodule
