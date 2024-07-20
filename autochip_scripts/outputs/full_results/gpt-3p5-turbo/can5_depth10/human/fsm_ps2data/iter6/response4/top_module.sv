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
    wire [1:0] next_state;
    wire [23:0] next_message;
    wire [2:0] next_counter;
    
    assign next_state = state;
    assign next_message = message;
    assign next_counter = counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            message <= 24'b0;
            counter <= 3'b000;
        end
        else begin
            state <= next_state;
            message <= next_message;
            counter <= next_counter;
        end
    end
    
    always @* begin
        case (state)
            2'b00: begin
                if (in[3]) begin
                    next_state = 2'b01;
                    next_message = {in, 16'b0};
                    next_counter = 3'b001;
                end
                else begin
                    next_state = 2'b00;
                    next_message = message;
                    next_counter = counter;
                end
            end
            2'b01: begin
                if (in[3]) begin
                    if (counter == 3'b010) begin
                        next_state = 2'b10;
                    end
                    else begin
                        next_state = 2'b01;
                    end
                    next_message = {in, message[23:8]};
                    next_counter = counter + 1;
                end
                else begin
                    next_state = 2'b00;
                    next_message = message;
                    next_counter = 3'b000;
                end
            end
            2'b10: begin
                next_state = 2'b00;
                next_message = message;
                next_counter = 3'b000;
            end
            default: begin
                next_state = 2'b00;
                next_message = message;
                next_counter = 3'b000;
            end
        endcase
    end

    assign out_bytes = (state == 2'b10 && counter == 3'b000) ? message : 24'b0;
    assign done = (state == 2'b10 && counter == 3'b000);
    
endmodule
