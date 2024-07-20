module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] counter;

    // State transition logic (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                if (counter == 8'hFF) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
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

    // Output logic and counter update (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'h00;
            valid_out <= 1'b0;
            counter <= 8'h00;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                    counter <= 8'h00;
                end

                WAIT: begin
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                    counter <= counter + 1;
                end

                PROCESS: begin
                    data_out <= 8'hAA; // Example data, replace with actual processing data as needed
                    valid_out <= 1'b0;
                end

                DONE: begin
                    valid_out <= 1'b1;
                end

                default: begin
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                    counter <= 8'h00;
                end
            endcase
        end
    end

endmodule
