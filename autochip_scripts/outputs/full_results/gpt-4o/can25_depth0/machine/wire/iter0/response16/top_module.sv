module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter == 4'b1111) // Some threshold, can be changed
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic and counter update
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= some_processed_data_function();
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end
    
    // Example data processing function
    function automatic [7:0] some_processed_data_function();
        // You can replace this with actual functionality
        some_processed_data_function = 8'b10101010;
    endfunction
    
endmodule
