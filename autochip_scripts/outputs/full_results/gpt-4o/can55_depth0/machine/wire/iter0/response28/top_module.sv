module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    // State declaration
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state;
    reg [7:0] counter;

    // State machine logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    if (counter >= 8'd10) begin  // Arbitrary threshold
                        state <= PROCESS;
                    end else begin
                        counter <= counter + 1;
                        data_out <= 8'b0;
                        valid <= 1'b0;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hFF; // Example processed data
                    valid <= 1'b0;
                    state <= DONE;
                end
                DONE: begin
                    valid <= 1'b1;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
