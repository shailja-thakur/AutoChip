module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out
);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    // Initialization
    initial begin
        state = IDLE;
        counter = 8'd0;
        data = 8'd0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'd0;
            data <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data <= 8'd0;
                    if (rst) begin
                        state <= IDLE;
                    end else begin
                        state <= WAIT;
                    end
                end

                WAIT: begin
                    if (counter >= 8'd9) begin
                        state <= PROCESS;
                    end else begin
                        counter <= counter + 1;
                        data <= 8'd0;
                        state <= WAIT;
                    end
                end

                PROCESS: begin
                    data <= in;
                    state <= DONE;
                end

                DONE: begin
                    data <= in;
                    state <= IDLE;
                end
            endcase
        end
    end

    assign out = data_out;

    // Output data and valid indication
    always @(posedge clk) begin
        if (state == PROCESS) begin
            data_out <= data;
            valid_out <= 1'b1;
        end else begin
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end
    end

endmodule
