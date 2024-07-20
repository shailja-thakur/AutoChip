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
    reg [7:0] in_reg;
    wire [7:0] in_sync;
    
    initial begin
        state = 2'b00;
        message = 24'b0;
        counter = 3'b000;
        in_reg = 8'b0;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            message <= 24'b0;
            counter <= 3'b000;
            in_reg <= 8'b0;
        end
        else begin
            in_reg <= in;
            in_sync <= in_reg;
            
            case (state)
                2'b00: begin
                    if (in_sync[3]) begin
                        state <= 2'b01;
                        message <= {in_sync, 16'b0};
                        counter <= 3'b001;
                    end
                end
                2'b01: begin
                    if (in_sync[3]) begin
                        if (counter == 3'b010) begin
                            state <= 2'b10;
                        end
                        else begin
                            state <= 2'b01;
                        end
                        message <= {in_sync, message[23:8]};
                        counter <= counter + 1;
                    end
                    else begin
                        state <= 2'b00;
                        counter <= 3'b000;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    counter <= 3'b000;
                end
                default: begin
                    state <= 2'b00;
                    counter <= 3'b000;
                end
            endcase
        end
    end

    assign out_bytes = (state == 2'b10 && counter == 3'b000) ? message : 24'b0;
    assign done = (state == 2'b10 && counter == 3'b000);
    
endmodule
