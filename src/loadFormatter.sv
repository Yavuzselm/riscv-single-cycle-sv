module loadFormatter(
    input logic [1:0] adressPoint,
    input logic [2:0] dataControl,
    input logic [31:0] ReadData,
    output logic [31:0] formattedData
);

    always_comb begin

        formattedData = 32'd0;

        case(dataControl)

        3'b000: begin
            if(adressPoint == 2'b00)
                formattedData = {{24{ReadData[7]}}, ReadData[7:0]};
            else if(adressPoint == 2'b01)
                formattedData = {{24{ReadData[15]}}, ReadData[15:8]};
            else if(adressPoint == 2'b10)
                formattedData = {{24{ReadData[23]}}, ReadData[23:16]};
            else if(adressPoint == 2'b11)
                formattedData = {{24{ReadData[31]}}, ReadData[31:24]};
        end

        3'b001: begin
            if(adressPoint[1] == 1'b0)
                formattedData = {{16{ReadData[15]}}, ReadData[15:0]};
            else if(adressPoint[1] == 1'b1)
                formattedData = {{16{ReadData[31]}}, ReadData[31:16]};
        end

        3'b010: begin
            formattedData = ReadData;
        end

        3'b100: begin
            if(adressPoint == 2'b00)
                formattedData = {24'd0, ReadData[7:0]};
            else if(adressPoint == 2'b01)
                formattedData = {24'd0, ReadData[15:8]};
            else if(adressPoint == 2'b10)
                formattedData = {24'd0, ReadData[23:16]};
            else if(adressPoint == 2'b11)
                formattedData = {24'd0, ReadData[31:24]};
        end

        3'b101: begin
            if(adressPoint[1] == 1'b0)
                formattedData = {16'd0, ReadData[15:0]};
            else if(adressPoint[1] == 1'b1)
                formattedData = {16'd0, ReadData[31:16]};
        end

        default: begin
            formattedData = 32'd0;
        end

        endcase
    end

endmodule
