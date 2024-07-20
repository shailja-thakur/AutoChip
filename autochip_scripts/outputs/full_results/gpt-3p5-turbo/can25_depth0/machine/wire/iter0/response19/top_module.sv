module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out
);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_out_reg;

    // state definitions
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else case (state)
            IDLE: begin
                counter <= 8'd0;
                data_out_reg <= 8'd0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out_reg <= 8'd0;
                if (counter == 8'd255) // set your desired threshold here
                    state <= PROCESS;
            end
            PROCESS: begin
                data_out_reg <= in;
                state <= DONE;
            end
            DONE: begin
                data_out_reg <= in;
                state <= IDLE;
            end
        endcase
    end

    assign data_out = data_out_reg;
    assign valid_out = (state == DONE);
    
endmodule
