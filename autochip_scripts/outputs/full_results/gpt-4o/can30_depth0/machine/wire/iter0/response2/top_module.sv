module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [7:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else if (state == IDLE) begin
                counter <= 8'd0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                data_out = 8'd0;
                valid_out = 1'b0;
                if (reset) begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                data_out = 8'd0;
                valid_out = 1'b0;
                if (counter == 8'd255) begin
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                data_out = 8'hAA; // Example processed data
                valid_out = 1'b0;
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
