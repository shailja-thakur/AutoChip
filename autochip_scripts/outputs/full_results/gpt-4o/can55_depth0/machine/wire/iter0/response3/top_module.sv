module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define internal signals
    reg [1:0] state, next_state;
    reg [3:0] counter;

    // State encoding
    localparam [1:0] IDLE = 2'b00,
                     WAIT = 2'b01,
                     PROCESS = 2'b10,
                     DONE = 2'b11;

    // FSM sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end
            if (state == DONE) begin
                valid_out <= 1'b1;
            end else begin
                valid_out <= 1'b0;
            end
        end
    end

    // FSM combinational logic
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                data_out = 8'b00000000;
            end
            WAIT: begin
                if (counter == 4'b1111) begin
                    next_state = PROCESS;
                end
                else begin
                    next_state = WAIT;
                end
            end
            PROCESS: begin
                data_out = 8'b10101010; // Example data processing logic
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
