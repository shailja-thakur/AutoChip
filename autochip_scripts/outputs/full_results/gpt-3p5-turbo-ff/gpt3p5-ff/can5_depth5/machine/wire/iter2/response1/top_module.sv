module top_module(
    input wire clk,
    input wire rst,
    input wire in,
    output wire out);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    
    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;
    
    wire data_out;
    wire valid_out;
    
    assign out = data_out;
    
    stimulus_gen stimulus_gen_inst(
        .clk(clk),
        .rst(rst),
        .data_out(data_out),
        .valid_out(valid_out)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'b0;
            data <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data <= 8'b0;
                    if (rst) state <= IDLE;
                    else state <= WAIT;
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    data <= 8'b0;
                    if (counter == 8'd255) state <= PROCESS;
                    else state <= WAIT;
                end
                
                PROCESS: begin
                    data <= in;
                    state <= DONE;
                end
                
                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
module stimulus_gen(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out);
    
    reg [7:0] data_reg;
    reg [7:0] threshold = 8'd255;
    reg [7:0] counter;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 8'b0;
            data_reg <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            counter <= counter + 1;
            if (counter == threshold) begin
                data_reg <= data_reg + 1;
                counter <= 8'b0;
                valid_out <= 1'b1;
            end else begin
                valid_out <= 1'b0;
            end
        end
    end
    
    assign data_out = data_reg;
    
endmodule
module top_module(
    input wire clk,
    input wire rst,
    input wire in,
    output wire out);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    
    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;
    
    wire data_out;
    wire valid_out;
    
    assign out = data_out;
    
    stimulus_gen stimulus_gen_inst(
        .clk(clk),
        .rst(rst),
        .data_out(data_out),
        .valid_out(valid_out)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'b0;
            data <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data <= 8'b0;
                    if (rst) state <= IDLE;
                    else state <= WAIT;
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    data <= 8'b0;
                    if (counter == 8'd255) state <= PROCESS;
                    else state <= WAIT;
                end
                
                PROCESS: begin
                    data <= in;
                    state <= DONE;
                end
                
                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
module stimulus_gen(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out);
    
    reg [7:0] data_reg;
    reg [7:0] threshold = 8'd255;
    reg [7:0] counter;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 8'b0;
            data_reg <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            counter <= counter + 1;
            if (counter == threshold) begin
                data_reg <= data_reg + 1;
                counter <= 8'b0;
                valid_out <= 1'b1;
            end else begin
                valid_out <= 1'b0;
            end
        end
    end
    
    assign data_out = data_reg;
    
endmodule
