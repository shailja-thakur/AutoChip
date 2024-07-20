module top_module (
    input clk,
    input rst,
    output reg out,
    output reg valid
);

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 0;
            data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    data <= 0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data <= 0;
                    if (counter == 256) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data <= in; // Replace 'in' with your input signal name
                    state <= DONE;
                end
                DONE: begin
                    valid <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

    // Output assignment
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 0;
            valid <= 0;
        end else begin
            case (state)
                IDLE: begin
                    out <= 0;
                    valid <= 0;
                end
                WAIT: begin
                    out <= 0;
                    valid <= 0;
                end
                PROCESS: begin
                    out <= data;
                    valid <= 0;
                end
                DONE: begin
                    out <= data;
                    valid <= 1;
                end
            endcase
        end
    end

endmodule
