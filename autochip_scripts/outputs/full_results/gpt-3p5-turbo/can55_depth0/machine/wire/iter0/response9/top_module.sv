module top_module(
    input in,
    output out,
    input clk,
    input reset
);
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_out;
    wire valid_out;

    // FSM states
    parameter idle = 2'b00;
    parameter wait = 2'b01;
    parameter process = 2'b10;
    parameter done = 2'b11;

    // Reset state
    always @(posedge reset)
    begin
        state <= idle;
        counter <= 8'd0;
        data_out <= 8'd0;
    end

    // FSM transitions and logic
    always @(posedge clk)
    begin
        case(state)
            idle: begin
                counter <= 8'd0;
                data_out <= 8'd0;
                state <= wait;
            end
            wait: begin
                counter <= counter + 1;
                data_out <= 8'd0;
                if(counter == 8'd10) // Change the threshold value as needed
                    state <= process;
            end
            process: begin
                data_out <= in;
                state <= done;
            end
            done: begin
                data_out <= in;
                state <= idle;
            end
        endcase
    end

    // Output assignment
    assign out = data_out;
    assign valid_out = (state == done);

endmodule
