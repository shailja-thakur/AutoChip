module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output wire [23:0] out_bytes,
    output wire done
);
    reg [23:0] message;
    reg [1:0] state;
    reg [2:0] counter;
    wire reset_prev = 1'b0;
    
    initial begin
        state = 2'b00;
        message = 24'b0;
        counter = 3'b000;
        reset_prev = 1'b0;
        out_bytes = 24'b0;
        done = 1'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 3'b000;
        end
        else begin
            state <= in[3] ? (state == 2'b10 ? 2'b00 : 2'b01) : (state == 2'b10 ? 2'b00 : 2'b00);
            
            if (reset_prev) begin
                message <= {in, 16'b0};
                counter <= 3'b001;
            end
            else if (state == 2'b01 && counter < 3'b010) begin
                message <= {in, message[23:8]};
                counter <= counter + 1;
            end
            else begin
                message <= {in, 16'b0};
                counter <= 3'b000;
            end
        end
        
        reset_prev <= reset;
    end

    assign out_bytes = (state == 2'b10 && counter == 3'b000) ? message : 24'b0;
    assign done = (state == 2'b10 && counter == 3'b000);
    
endmodule
