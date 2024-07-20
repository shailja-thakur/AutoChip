module stimulus_gen(
    input clk,
    input rst,
    output data_out,
    output valid
);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    // Idle state
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= 2'b00;
        else
            state <= 2'b01;
    end

    // Wait state
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            counter <= 8'b0;
        end
        else begin
            if (state == 2'b01) begin
                counter <= counter + 8'b1;
                if (counter == 8'hFF)
                    state <= 2'b10;
            end
        end
    end

    // Process state
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= 2'b00;
        else if (state == 2'b10)
            state <= 2'b11;
    end

    // Done state
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= 2'b00;
        else if (state == 2'b11)
            state <= 2'b00;
    end

    // Output logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data <= 8'b0;
            valid <= 1'b0;
        end
        else begin
            case(state)
                2'b00: begin // Idle state
                    data <= 8'b0;
                    valid <= 1'b0;
                end
                2'b01: begin // Wait state
                    data <= 8'b0;
                    valid <= 1'b0;
                end
                2'b10: begin // Process state
                    data <= in;
                    valid <= 1'b0;
                end
                2'b11: begin // Done state
                    data <= in;
                    valid <= 1'b1;
                end
            endcase
        end
    end

    assign data_out = data;
endmodule
module top_module(
    input clk,
    input rst,
    output data_out,
    output valid
);

    stimulus_gen stim_gen (.clk(clk), .rst(rst), .data_out(data_out), .valid(valid));

endmodule
